Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUFCGiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUFCGiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUFCGiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:38:14 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:16753 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261234AbUFCGiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:38:11 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Subject: Re: [RFC/RFT] Raw access to serio ports (1/2)
Date: Thu, 3 Jun 2004 01:38:10 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       bilotta78@hotpop.com, vojtech@suse.cz, tuukkat@ee.oulu.fi
References: <200406020218.42979.dtor_core@ameritech.net> <200406030045.51102.dtor_core@ameritech.net> <xb7llj540o3.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb7llj540o3.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="big5"
Content-Transfer-Encoding: 7bit
Message-Id: <200406030138.10102.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2004 01:26 am, Sau Dan Lee wrote:
> >>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:
> 
>     Dmitry> +config INPUT_RAWDEV
>     Dmitry> +	tristate "Raw access to serio ports"
>     Dmitry> +	depends on INPUT && INPUT_MISC
>     Dmitry> +	help
> 
> Since this provides raw access  to serio ports ONLY, shouldn't it also
> depend on INPUT_SERIO?

Yes, you are right, will change.

> Shall we better call it SERIO_RAW? 
> 

I could probably rename it to serio_rawdev... It's close to 2AM here so the
next version is due tomorrow night ;) 

-- 
Dmitry
