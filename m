Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291571AbSBML0I>; Wed, 13 Feb 2002 06:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291566AbSBMLZ6>; Wed, 13 Feb 2002 06:25:58 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:44301 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S291563AbSBMLZm>; Wed, 13 Feb 2002 06:25:42 -0500
Date: Wed, 13 Feb 2002 12:25:38 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020213112538.GA6533@merlin.emma.line.org>
Mail-Followup-To: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3C6A418A.8040105@evision-ventures.com> <Pine.LNX.4.10.10202130228180.1479-100000@master.linux-ide.org> <20020213105625.GI32687@atrey.karlin.mff.cuni.cz> <3C6A49F1.5000500@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6A49F1.5000500@evision-ventures.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Martin Dalecki wrote:

> Silly code like that:
> 
>      ide_add_setting(drive,  "bios_cyl",             
> SETTING_RW,            

Why do you call it "silly" to encapsulate all that stuff and create and
change attributes (bios_cyl) through an object (drive)? I fail to see
your point, looks rather like bash & flame. It's not silly because it's
a different approach or style.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
