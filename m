Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbTBCWaq>; Mon, 3 Feb 2003 17:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266953AbTBCWaq>; Mon, 3 Feb 2003 17:30:46 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:57478 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S266952AbTBCWap>; Mon, 3 Feb 2003 17:30:45 -0500
Date: Mon, 3 Feb 2003 16:40:13 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Konrad Eisele <eiselekd@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Customflags for cmd_objcopy
In-Reply-To: <200302031605.h13G5nO30068@mailgate5.cinetic.de>
Message-ID: <Pine.LNX.4.44.0302031639120.32421-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2003, Konrad Eisele wrote:

> like with cmd_ld in scripts/Makefile.lib having possibility to add 
> customflags with cmk_objcopy would be nice. When building a ROMKernel
> I'd like to use:
> OBJCOPYFLAGS_rompiggydata := --remove-section=.text
> OBJCOPYFLAGS_$(MODEL)piggytext := --only-section=.text

Makes sense. Could you send your $(if_changed ) thing as patch, too? And 
possibly for all if_changed_*? (Privately will do)

--Kai


