Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbVKKXl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVKKXl7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVKKXl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:41:59 -0500
Received: from gate.crashing.org ([63.228.1.57]:54991 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751322AbVKKXl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:41:58 -0500
Subject: Re: [PATCH] nvidiafb: Fix bug in nvidiafb_pan_display
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, "Antonino A. Daplas" <adaplas@pol.net>
In-Reply-To: <4375291F.3040508@gmail.com>
References: <20051110203544.027e992c.akpm@osdl.org>
	 <6bffcb0e0511111432m771dcda2y@mail.gmail.com>
	 <20051111150108.265b2d3f.akpm@osdl.org>  <4375291F.3040508@gmail.com>
Content-Type: text/plain
Date: Sat, 12 Nov 2005 10:38:23 +1100
Message-Id: <1131752304.24637.260.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-12 at 07:28 +0800, Antonino A. Daplas wrote:
> nvidiafb_pan_display() is incorrectly using the fields in
> info->var instead of var passed to the function.

Shouldn't it also update info->var is is this done by the core ?

Ben.


