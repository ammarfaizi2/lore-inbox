Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264957AbRFZOe4>; Tue, 26 Jun 2001 10:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbRFZOeq>; Tue, 26 Jun 2001 10:34:46 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:10003 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265010AbRFZOec>;
	Tue, 26 Jun 2001 10:34:32 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Tim Waugh <twaugh@redhat.com>
cc: Simon Huggins <huggie@earth.li>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: parport_pc tries to load parport_serial automatically 
In-Reply-To: Your message of "Tue, 26 Jun 2001 14:53:55 +0100."
             <20010626145355.Z7663@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Jun 2001 00:34:25 +1000
Message-ID: <11667.993566065@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2001 14:53:55 +0100, 
Tim Waugh <twaugh@redhat.com> wrote:
>On Tue, Jun 26, 2001 at 11:37:19PM +1000, Keith Owens wrote:
>
>> "below parport_pc parport-serial" is even cleaner.  One line, modprobe
>> does everything else.
>
>Would this have any different effect than the current situation if
>parport_serial fails to load?

It behaves the same as an inter-module dependency, if parport-serial
fails then parport_pc will not be loaded.  If I remember correctly,
this was suggested in the context that people who want both should put
something in modules.conf, IOW this is what the user asked for.

