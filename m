Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVDFLc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVDFLc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 07:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVDFLc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 07:32:58 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:904 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262167AbVDFLcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 07:32:48 -0400
Date: Wed, 6 Apr 2005 13:32:33 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Renate Meijer <kleuske@xs4all.nl>
Cc: Blaisorblade <blaisorblade@yahoo.it>, stable@kernel.org,
       Greg KH <gregkh@suse.de>, jdike@karaya.com,
       linux-kernel@vger.kernel.org
Subject: Re: [08/08] uml: va_copy fix
Message-ID: <20050406113233.GD7031@wohnheim.fh-wedel.de>
References: <20050405164539.GA17299@kroah.com> <20050405164815.GI17299@kroah.com> <c8cb775b8f5507cbac1fb17b1028cffc@xs4all.nl> <200504052053.20078.blaisorblade@yahoo.it> <7aa6252d5a294282396836b1a27783e8@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7aa6252d5a294282396836b1a27783e8@xs4all.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 April 2005 22:18:26 +0200, Renate Meijer wrote:
> 
> If a function is prefixed with a double underscore, this implies the 
> function is internal to
> the compiler, and may change at any time, since it's not governed by 
> some sort of standard.
> Hence that code may start suffering from bitrot and complaining to the 
> compiler guys won't help.

You did read include/linux/compiler.h, didn't you?
And you did read this thread as well, right?
http://kerneltrap.org/node/4126

Jörn

-- 
Time? What's that? Time is only worth what you do with it.
-- Theo de Raadt
