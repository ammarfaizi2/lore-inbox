Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266158AbUF3GrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266158AbUF3GrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 02:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUF3GrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 02:47:12 -0400
Received: from holomorphy.com ([207.189.100.168]:52397 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266158AbUF3Gpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 02:45:43 -0400
Date: Tue, 29 Jun 2004 23:45:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: s390(64) per_cpu in modules (ipv6)
Message-ID: <20040630064532.GF21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pete Zaitcev <zaitcev@redhat.com>, schwidefsky@de.ibm.com,
	linux-kernel@vger.kernel.org
References: <20040629233537.523db68c@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040629233537.523db68c@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 11:35:37PM -0700, Pete Zaitcev wrote:
> It seems to work fine, but I'm wondering if a better fix can be found.
> Ideas?
> -- Pete

How does __attribute__((used)) fare?


-- wli
