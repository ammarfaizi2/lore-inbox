Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWEJOHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWEJOHR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 10:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWEJOHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 10:07:16 -0400
Received: from [63.81.120.158] ([63.81.120.158]:4711 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751353AbWEJOHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 10:07:15 -0400
Subject: Re: [PATCH -mm] idetape gcc 4.1 warning fix
From: Daniel Walker <dwalker@mvista.com>
To: Jakub Jelinek <jakub@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060510111205.GQ14147@devserv.devel.redhat.com>
References: <200605100255.k4A2twOE031688@dwalker1.mvista.com>
	 <20060510111205.GQ14147@devserv.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 10 May 2006 07:07:10 -0700
Message-Id: <1147270031.21536.58.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 07:12 -0400, Jakub Jelinek wrote:

> WARN_ON is certainly not a good way to hide this warning.
> Having a user-triggerable WARN_ON is a bad idea.
> Instead you should add some error handling.

This was one of 3 or so functions that had no return facility . I had a
feeling people wouldn't agree with the WARN_ON() , so I'm hoping someone
has a better solution . Could just be a printk , but I'm not going to
revamp the drivers error handling just to cure the warning .

Daniel

