Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281593AbRKUFTY>; Wed, 21 Nov 2001 00:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281594AbRKUFTO>; Wed, 21 Nov 2001 00:19:14 -0500
Received: from zok.SGI.COM ([204.94.215.101]:908 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S281593AbRKUFTD>;
	Wed, 21 Nov 2001 00:19:03 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: [VMBUG] 2.4.15-pre7 Severe VM Bugs in 2.4.15-pre7 
In-Reply-To: Your message of "Tue, 20 Nov 2001 23:14:49 PDT."
             <20011120231449.A3637@vger.timpanogas.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 Nov 2001 16:18:27 +1100
Message-ID: <3562.1006319907@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001 23:14:49 -0700, 
"Jeff V. Merkey" <jmerkey@vger.timpanogas.org> wrote:
>ksymoops 2.4.0 on i686 2.4.15-pre7.  Options used
>     -m /boot/System.map-2.4.15-pre7 (default)
>Error (regular_file): read_system_map stat /boot/System.map-2.4.15-pre7 failed

Without a valid System.map, the decode is going to be very vague.  When
you see offset 5207 in code sized 32410 you know you don't have enough
detail.  Try the decode again with a valid System.map.

