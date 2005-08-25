Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVHYEjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVHYEjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 00:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVHYEjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 00:39:54 -0400
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:63877 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964787AbVHYEjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 00:39:53 -0400
Date: Thu, 25 Aug 2005 00:39:49 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Chris Wright <chrisw@osdl.org>
cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org,
       Kurt Garloff <garloff@suse.de>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH 0/5] LSM hook updates
In-Reply-To: <20050825012028.720597000@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0508250038450.13875@excalibur.intercode>
References: <20050825012028.720597000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2005, Chris Wright wrote:

> This is based on Kurt's original work.  The net effect is that
> LSM hooks are called conditionally, and in all cases capabilities
> provide the defaults.  I've done some basic performance testing, and
> found nothing surprising.

Do you mean nothing noticable?

>  I'm interested to see numbers from others
> before I push this up.  These are against Linus' current git tree (they
> will clash with the -mm tree).

Are there any numbers for popular architectures like i386 and x86_64?


- James
-- 
James Morris
<jmorris@namei.org>
