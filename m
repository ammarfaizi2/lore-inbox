Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKDKnf>; Sat, 4 Nov 2000 05:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbQKDKnZ>; Sat, 4 Nov 2000 05:43:25 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:23824 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129033AbQKDKnO>;
	Sat, 4 Nov 2000 05:43:14 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: tytso@mit.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10) 
In-Reply-To: Your message of "Fri, 03 Nov 2000 10:09:31 CDT."
             <200011031509.eA3F9V719729@trampoline.thunk.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 Nov 2000 21:43:06 +1100
Message-ID: <6647.973334586@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2000 10:09:31 -0500, 
tytso@mit.edu wrote:
>9. To Do
>     * DRM cannot use AGP support module when CONFIG_MODVERSIONS is
>       defined (issue with get_module_symbol caused fix proposed by John
>       Levon to be rejected)

Move this to "in progress" and add MTD code breaks with
CONFIG_MODVERSIONS, for the same reason.  I wrote a patch to replace
get_module_symbol a week ago and sent it to the DRM/AGP/MTD people for
testing - no response yet.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
