Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUC0Vkl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 16:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUC0Vkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 16:40:41 -0500
Received: from 69-150-147-130.ded.swbell.net ([69.150.147.130]:5790 "HELO
	arumekun.no-ip.com") by vger.kernel.org with SMTP id S261880AbUC0Vkk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 16:40:40 -0500
From: Luke-Jr <luke-jr@artcena.com>
To: swsusp-devel@lists.sourceforge.net
Subject: Re: Paranoia is fun [Was Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]]]
Date: Sat, 27 Mar 2004 21:40:33 +0000
User-Agent: KMail/1.6.1
Cc: "Michael Frank" <mhf@linuxmail.org>, "Micha Feigin" <michf@post.tau.ac.il>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20040323233228.GK364@elf.ucw.cz> <200403272003.35410.luke-jr@artcena.com> <opr5jgous34evsfm@smtp.pacific.net.th>
In-Reply-To: <opr5jgous34evsfm@smtp.pacific.net.th>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403272140.33356.luke-jr@artcena.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 March 2004 09:01 pm, Michael Frank wrote:
> ... so one really would not want to put the key there.
Right.
>
> Each and every shortcut is unsafe as it somwhere has to store the
> full key and could be reverse engineered and broken "easily"
> relative to breaking the key.
If the key is based on hardware details that only root can obtain, it would 
require at least having the time to boot the victim computer into another OS 
to create the key. If the key is also dependant on details of the running 
kernel, it could be even harder to crack it.

Password-based encryption might be wanted for certain cases, but I think most 
cases would do fine to prevent the image from being used for anything except 
restoring on the original system. That way, it would be significantly more 
difficult for someone to gain access to the memory that could be used for 
other encrypted things (such as GPG key generation).
