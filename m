Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUL0R10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUL0R10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 12:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUL0R10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 12:27:26 -0500
Received: from coderock.org ([193.77.147.115]:53989 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261931AbUL0R1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 12:27:23 -0500
Date: Mon, 27 Dec 2004 18:27:39 +0100
From: Domen Puncer <domen@coderock.org>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i2c-parport boot time parameters
Message-ID: <20041227172739.GB18084@nd47.coderock.org>
References: <20041227132307.GA3247@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227132307.GA3247@beton.cybernet.src>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/04 13:23 +0000, Karel Kulhavy wrote:
> Hello
> 
> Is it possible to configure i2c-parport driver using boot time commandline
> parameters? If so, where are these parameters described? I found just
> description of module parameters using modinfo i2c-parport.

Yes, for modules that use module_param (i2c-parport does), you can
use module.parameter=blah in boot line.

This is described in Documentation/kernel-parameters.txt


	Domen
