Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273569AbRIQLP4>; Mon, 17 Sep 2001 07:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273570AbRIQLPq>; Mon, 17 Sep 2001 07:15:46 -0400
Received: from ikar.t17.ds.pwr.wroc.pl ([156.17.235.253]:29965 "EHLO
	ikar.t17.ds.pwr.wroc.pl") by vger.kernel.org with ESMTP
	id <S273569AbRIQLPZ>; Mon, 17 Sep 2001 07:15:25 -0400
Date: Mon, 17 Sep 2001 13:15:40 +0200
From: Artur Frysiak <wiget@pld.org.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modutils: ieee1394 device_id extraction
Message-ID: <20010917131540.B27430@ikar.t17.ds.pwr.wroc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <29177.1000629997@ocs3.intra.ocs.com.au> <m3pu8rh20i.fsf@dk20037170.bang-olufsen.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3pu8rh20i.fsf@dk20037170.bang-olufsen.dk>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 12:18:53PM +0200, Kristian Hogsberg wrote:
> @@ -1225,6 +1306,8 @@
>  	if (usbmap != stdout)
>  		fclose(usbmap);
>  	if (parportmap != stdout)
> +		fclose(parportmap);
> +	if (ieee1394map != stdout)
>  		fclose(parportmap);
>  	/* Close depfile last, it's timestamp is critical */
>  	if (dep != stdout)

I think, this part is bad. You test for ieee139map file pointer and close
parportmap.

Regards
-- 
Artur Frysiak
http://www.pld.org.pl/
