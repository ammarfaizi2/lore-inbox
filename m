Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263425AbTC2OdD>; Sat, 29 Mar 2003 09:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263426AbTC2OdC>; Sat, 29 Mar 2003 09:33:02 -0500
Received: from [81.2.110.254] ([81.2.110.254]:31987 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S263425AbTC2OdC>;
	Sat, 29 Mar 2003 09:33:02 -0500
Subject: Re: 845GE Chipset severe performance problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Craig Robinson <craig.robinson@btinternet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <188481168784.20030329130300@btinternet.com>
References: <188481168784.20030329130300@btinternet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048949147.6725.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 29 Mar 2003 14:45:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check the mtrr ranges. The odd junk bios gets this wrong and leaves
you with parts of main memory uncached. The symptoms you see might
be from that if they are all identical boxes.

Alan

