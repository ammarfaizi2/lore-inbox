Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275811AbRJJNvv>; Wed, 10 Oct 2001 09:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275798AbRJJNuj>; Wed, 10 Oct 2001 09:50:39 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:57361 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S275790AbRJJNua>;
	Wed, 10 Oct 2001 09:50:30 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Tainted Modules Help Notices 
In-Reply-To: Your message of "Wed, 10 Oct 2001 09:20:58 +0100."
             <3869.1002702058@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Oct 2001 23:50:48 +1000
Message-ID: <13388.1002721848@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001 09:20:58 +0100, 
David Woodhouse <dwmw2@infradead.org> wrote:
>BSD-licensed modules shouldn't mark the kernel as tainted. If they do, 
>that's surely a bug.

Any license not listed in include/linux/module.h is not GPL compatible.
That list is currently (2.4.11)

"GPL"                           [GNU Public License v2 or later]
"GPL and additional rights"     [GNU Public License v2 rights and more]
"Dual BSD/GPL"                  [GNU Public License v2 or BSD license choice]
"Dual MPL/GPL"                  [GNU Public License v2 or Mozilla license choice]

>The warning should probably read 'Incompatible licence' instead of 'non-GPL',
>too.

No.  Any license text not approved as GPL compatible is, by definition,
incompatible.

