Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRBTKbB>; Tue, 20 Feb 2001 05:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129377AbRBTKav>; Tue, 20 Feb 2001 05:30:51 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:10513 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129664AbRBTKal>;
	Tue, 20 Feb 2001 05:30:41 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: He-Who-Is-Not-Subscribed-to-LKML <acapnotic@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.1] system goes glacial, Reiser on /usr doesn't sync 
In-Reply-To: Your message of "Tue, 20 Feb 2001 02:16:09 -0800."
             <20010220021609.B11523@troglodyte.menefee> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Feb 2001 21:30:34 +1100
Message-ID: <7435.982665034@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001 02:16:09 -0800, 
Kevin Turner <acapnotic@users.sourceforge.net> wrote:
>[binfmt_misc:__insmod_binfmt_misc_O/lib/modules/2.4.1-pre12/kernel/fs/bi+-621596/96]
>
>Why binfmt_misc?  I'll be burned if I know.

Because klogd conversion of addresses to symbols is a pile of crud.
Turn off klogd symbol conversion (klogd -x) and run the raw addresses
through ksymoops.

