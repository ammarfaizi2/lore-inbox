Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269266AbTGORr0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269202AbTGORqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:46:23 -0400
Received: from gsd.di.uminho.pt ([193.136.20.132]:27049 "EHLO
	bbb.lsd.di.uminho.pt") by vger.kernel.org with ESMTP
	id S269255AbTGORoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:44:21 -0400
Date: Tue, 15 Jul 2003 18:59:09 +0100
From: Luciano Miguel Ferreira Rocha <luciano@lsd.di.uminho.pt>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interrupt doesn't make it to the 8259 on a ASUS P4PE mobo
Message-ID: <20030715175909.GA17226@lsd.di.uminho.pt>
References: <PMEMILJKPKGMMELCJCIGOEKNCCAA.kfrazier@mdc-dayton.com> <3F14348B.4050606@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F14348B.4050606@didntduck.org>
User-Agent: Mutt/1.4.1i
X-Disclaimer: 'Author of this message is not responsible for any harm done to reader's computer.'
X-Organization: 'GSD'
X-Section: 'BIC'
X-Priority: '1 (Highest)'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 01:06:19PM -0400, Brian Gerst wrote:
> Use HZ/2 instead.  GCC doesn't optimize floating point constants to the 
> same degree it does integers, because it doesn't know what mode 
> (rounding, precision) the FPU is in.

Isn't (HZ >> 1) better?

Regards,
Luciano Rocha
