Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263968AbSJVQYA>; Tue, 22 Oct 2002 12:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbSJVQYA>; Tue, 22 Oct 2002 12:24:00 -0400
Received: from trillium-hollow.org ([209.180.166.89]:30858 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S263968AbSJVQYA>; Tue, 22 Oct 2002 12:24:00 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
cc: landley@trommello.org, Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux) 
In-Reply-To: Your message of "22 Oct 2002 10:02:03 MDT."
             <m11y6itqbo.fsf@frodo.biederman.org> 
Date: Tue, 22 Oct 2002 09:30:07 -0700
From: erich@uruk.org
Message-Id: <E1841ux-00027S-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, of course, %ds is the implicit source/dest of all but a few memory
referencing ops, so not loading that is bound to lead to trouble in most
cases...

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
