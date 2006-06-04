Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932106AbWFDJiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWFDJiF (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWFDJiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:38:05 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:20176 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751264AbWFDJiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:38:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=fCHnCWn+QGmR6guVOtE4FHSI1lKAwuUFnrrpJqNApIVwsDDozS8Ce7ydykcm/RBeCfZmyojduiED9JOD7V57GNifYe7qmacPp9pHMQ+KKsqLIEAaqFDyuvIbOSn7Wc15g/iE8zK2AOBm7YY2LEJ2eH1vBUiW97pdvKkIZJ6g1GE=
Message-ID: <986ed62e0606040238t712d7b01xde5f4a23da12fb1a@mail.gmail.com>
Date: Sun, 4 Jun 2006 02:38:03 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm3
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060603232004.68c4e1e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060603232004.68c4e1e3.akpm@osdl.org>
X-Google-Sender-Auth: 04de83368b734aa5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I build ACPI processor support as a module, I get this:

  MODPOST
WARNING: drivers/acpi/processor.o - Section mismatch: reference to
.init.data: from .text between 'acpi_processor_power_init' (at offset
0xfb0) and 'acpi_safe_halt'

(This is also true of -mm2, but I didn't get a chance to report it
before -mm3 was released. Before then, I built it into the kernel and
not as a module.)

and I still get this:
WARNING: "scsi_tgt_queue_command" [drivers/scsi/libsrp.ko] undefined!
-- 
-Barry K. Nathan <barryn@pobox.com>
