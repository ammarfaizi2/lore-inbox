Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbRFZNhw>; Tue, 26 Jun 2001 09:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264941AbRFZNhm>; Tue, 26 Jun 2001 09:37:42 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:63250 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264940AbRFZNhZ>;
	Tue, 26 Jun 2001 09:37:25 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Simon Huggins <huggie@earth.li>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: parport_pc tries to load parport_serial automatically 
In-Reply-To: Your message of "Tue, 26 Jun 2001 14:55:31 +0200."
             <20010626145531.J3776@paranoidfreak.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jun 2001 23:37:19 +1000
Message-ID: <11144.993562639@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2001 14:55:31 +0200, 
Simon Huggins <huggie@earth.li> wrote:
>Can't people who have such things just put:
>pre-install insmod parport-serial
>post-rm rmmod parport-serial
>in modules.conf?

"below parport_pc parport-serial" is even cleaner.  One line, modprobe
does everything else.

