Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbUJ0N20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbUJ0N20 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbUJ0N2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:28:25 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:61103 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262429AbUJ0N2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:28:04 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Subject: Re: Problem with module parameters and sysfs
Date: Wed, 27 Oct 2004 08:27:57 -0500
User-Agent: KMail/1.6.2
Cc: Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>
References: <200410270143.54852.dtor_core@ameritech.net> <20041027085842.GA7510@dominikbrodowski.de>
In-Reply-To: <20041027085842.GA7510@dominikbrodowski.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410270827.58079.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 October 2004 03:58 am, Dominik Brodowski wrote:
> On Wed, Oct 27, 2004 at 01:43:54AM -0500, Dmitry Torokhov wrote:
> > total 0
> > drwxr-xr-x    3 root     root            0 Oct 27 00:21 .
> > drwxr-xr-x   54 root     root            0 Oct 27 00:28 ..
> > -r--r--r--    1 root     root         4096 Oct 27 00:21 refcnt
> > drwxr-xr-x    2 root     root            0 Oct 27 00:21 sections
> > 
> > psmouse is built as a module while i8042 is compiled in.
> 
> All module_params I can see in psmouse have permission "0", so they don't
> need to be exported in sysfs. Or am I missing something here?
> 

Ahem... Hand me that paper bag please...

Sorry for the noise, I did not find the params directory and assumed that
something went wrong without even thinking about permissions.

-- 
Dmitry
