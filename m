Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263888AbSITWoR>; Fri, 20 Sep 2002 18:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263893AbSITWoR>; Fri, 20 Sep 2002 18:44:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60364 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263888AbSITWoQ> convert rfc822-to-8bit; Fri, 20 Sep 2002 18:44:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Guido Arenstedt <ga200@doc.ic.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading in -ac series
Date: Fri, 20 Sep 2002 15:47:59 -0700
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.42.0209202323530.23572-100000@faya.doc.ic.ac.uk>
In-Reply-To: <Pine.LNX.4.42.0209202323530.23572-100000@faya.doc.ic.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209201547.59508.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 September 2002 03:36 pm, Guido Arenstedt wrote:
> Hyperthreading does not seem to work in the -ac series
> it works fine with a stock 2.4.19 kernel
>
> during bootup i only get the message:
> WARNING: No sibling found for CPU 0.
> WARNING: No sibling found for CPU 1.
>
> or is this done on purpose?

The latter.  Hyperthreading _is_ working in the kernel, but it is not finding 
"sibling" CPUs to match the real ones.  (Or, as we prefer to call them, 
DiVitos to match the Schwartzenegers.  ;^)

Check your BIOS.  Some turn off hyperthreading by default.  (Notably, IBM's 
x440....)

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

