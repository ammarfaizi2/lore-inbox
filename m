Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318839AbSHWOgQ>; Fri, 23 Aug 2002 10:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318844AbSHWOgP>; Fri, 23 Aug 2002 10:36:15 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:45072 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S318839AbSHWOgP>; Fri, 23 Aug 2002 10:36:15 -0400
Date: Fri, 23 Aug 2002 16:40:16 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: barrie_spence@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 - Promise TX2 Ultra133 (pdc20269) sticks at UDMA33
Message-ID: <20020823144016.GM14278@louise.pinerecords.com>
References: <C12D24916888D311BC790090275414BB0B724742@oberon.britain.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C12D24916888D311BC790090275414BB0B724742@oberon.britain.agilent.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 80 days, 1:31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Trying hdparm -X69 after boot gives the message "Speed warnings UDMA 3/4/5 is not functional."

Known issue.
Boot/load the ide core mod with ideX=ata66, repeat for all your promise hosts.
