Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315575AbSENJkj>; Tue, 14 May 2002 05:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315577AbSENJki>; Tue, 14 May 2002 05:40:38 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:31495 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315575AbSENJke>;
	Tue, 14 May 2002 05:40:34 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Wickus Botha <Wickus@na.co.za>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: hd.c not compiling. 
In-Reply-To: Your message of "Tue, 14 May 2002 10:24:51 +0200."
             <297DCD5CCA4AD411A246009027F646B30276489D@NETMAIL> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 May 2002 19:40:22 +1000
Message-ID: <9998.1021369222@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002 10:24:51 +0200, 
Wickus Botha <Wickus@na.co.za> wrote:
>I'm busy testing the new development kernel 2.5.15. Each time it gets to
>compiling the ide stuff it fails. 
>hd.c: In function `hd_out':
>hd.c:282: `TIMEOUT_VALUE' undeclared (first use in this function)

That is the only hd only driver.  It has not been updated to follow
recent 2.5 changes.  Unless you want the old hd only code, set
CONFIG_BLK_DEV_HD_IDE=n and use the newer driver for all IDE disks.

