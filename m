Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266891AbRGMN74>; Fri, 13 Jul 2001 09:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266892AbRGMN7q>; Fri, 13 Jul 2001 09:59:46 -0400
Received: from mail.atl.external.lmco.com ([192.35.37.50]:59376 "HELO
	enterprise.atl.lmco.com") by vger.kernel.org with SMTP
	id <S266891AbRGMN7h>; Fri, 13 Jul 2001 09:59:37 -0400
Date: Fri, 13 Jul 2001 09:59:34 -0400
From: Chuck Winters <cwinters@atl.lmco.com>
To: linux-kernel@vger.kernel.org
Subject: Number of File descriptors
Message-ID: <20010713095934.A6100@atl.lmco.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
	My interest has been peaked by a recent email.  At one point, I heard two people speaking
about how some database guy wanted to have 2000 open files(or something crazy like that).  
They said that he must be crazy because the kernel does a sequential search through the open
file descriptors.  Anyway, I read a posting an a mail list that someone wanted select to 
select on 3000 files.  Alright, the question(Finally!):
		To have select() select on 3000 file descriptors, they must be open.  That's 3000 open
		files.  Will select be ultra slow trying to select on 3000 file descriptors?  Also, 
		what is the clarification on the kernel doing a sequential search through the open
		file descriptors?

Thanks In Advance,
Chuck Winters
