Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290742AbSA3XeV>; Wed, 30 Jan 2002 18:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290747AbSA3XeM>; Wed, 30 Jan 2002 18:34:12 -0500
Received: from zok.sgi.com ([204.94.215.101]:11455 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S290746AbSA3Xd6>;
	Wed, 30 Jan 2002 18:33:58 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: raul@viadomus.com, linux-kernel@vger.kernel.org
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*... 
In-Reply-To: Your message of "Wed, 30 Jan 2002 13:24:22 CDT."
             <200201301824.g0UIOMO32639@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 Jan 2002 10:33:46 +1100
Message-ID: <5960.1012433626@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002 13:24:22 -0500, 
Pete Zaitcev <zaitcev@redhat.com> wrote:
>Kernel headers are not to be included in applications.

Just to flog this dead horse into the ground, the reverse is also true.
Kernel code must not include user space headers (kernel code excludes
programs that are used to build the kernel).

