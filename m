Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSGERlV>; Fri, 5 Jul 2002 13:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317518AbSGERlV>; Fri, 5 Jul 2002 13:41:21 -0400
Received: from moutvdomng1.kundenserver.de ([195.20.224.131]:28147 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317517AbSGERlU>; Fri, 5 Jul 2002 13:41:20 -0400
Date: Fri, 5 Jul 2002 11:43:34 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Pablo Fischer <exilion@yifan.net>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: RE: StackPages errors (CALLTRACE)
In-Reply-To: <IDEJJDGBFBNEKLNKFPAEEEAJCDAA.exilion@yifan.net>
Message-ID: <Pine.LNX.4.44.0207051125380.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 5 Jul 2002, Pablo Fischer wrote:
> 1) Its more a HW problem? (a PRocessor problem?) I have AMD K6
> 
> 2) So.. you are telling me that I cant solve it? :(, only if I change the
> proccessor to a Pentium?..

It's a problem with the module code. It should be sufficient to replace 
cmov with something that can execute on < P6. That means, hand-checking, 
depending on !CONFIG_MPENTIUM4.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

