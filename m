Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267860AbRHAXzf>; Wed, 1 Aug 2001 19:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267875AbRHAXzZ>; Wed, 1 Aug 2001 19:55:25 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:30224 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267860AbRHAXzQ>;
	Wed, 1 Aug 2001 19:55:16 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: RFC: moving ACPI includes under include/ 
In-Reply-To: Your message of "Wed, 01 Aug 2001 15:40:48 MST."
             <4148FEAAD879D311AC5700A0C969E89006CDE006@orsmsx35.jf.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 02 Aug 2001 09:55:03 +1000
Message-ID: <19806.996710103@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001 15:40:48 -0700 , 
"Grover, Andrew" <andrew.grover@intel.com> wrote:
>The ACPI driver currently has its own little include directory under
>drivers/acpi.
>
>...thinking about moving these to include/acpi -- that seems to be the
>dominant Linux paradigm. Sound reasonable?

Good idea.  SCSI used to have include/scsi but moved the include files
to drivers/scsi and it is obvious that the move was a mistake.  Far too
much code has abominations like #include "../../scsi/hosts.h".  large
enough sub systems should have their own directory under include.

