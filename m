Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSLIAM1>; Sun, 8 Dec 2002 19:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSLIAM1>; Sun, 8 Dec 2002 19:12:27 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:11996 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261908AbSLIAM0>; Sun, 8 Dec 2002 19:12:26 -0500
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Four function buttons on DELL Latitude X200
In-Reply-To: <m3d6ocjd81.fsf@Janik.cz>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.14-20020917 ("Chop Suey!") (UNIX) (Linux/2.4.18-xfs (i686))
Message-Id: <E18LBeK-00046y-00@calista.inka.de>
Date: Mon, 09 Dec 2002 01:19:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m3d6ocjd81.fsf@Janik.cz> you wrote:
> this patch add support for four functions key on DELL Latitude X200.

we need a more generic appoach to handle those key codes for various
extensions. I think a pure software reconfiguration of the keymaps or a
daemon trakcing the raw codes is fine. Perhaps we can make something like a
hook into the kernel where all untrapped function keys are send to in raw
format?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
