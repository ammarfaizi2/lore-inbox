Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262994AbUKYHAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbUKYHAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 02:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbUKYHAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 02:00:48 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:57441 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262994AbUKYG7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 01:59:15 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge: 46/51: LZF support.
Date: Thu, 25 Nov 2004 01:52:33 -0500
User-Agent: KMail/1.6.2
Cc: hugang@soulinfo.com, Nigel Cunningham <ncunningham@linuxmail.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101350324.25030.0.camel@desktop.cunninghams> <20041125063242.GA31753@hugang.soulinfo.com>
In-Reply-To: <20041125063242.GA31753@hugang.soulinfo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411250152.33330.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 25 November 2004 01:32 am, hugang@soulinfo.com wrote:
....
> +
> +  if (lit)
> +    {
> +      if (op + lit + 1 >= out_end)
> +	return 0;
> +
> +      *op++ = lit - 1;
> +      lit = -lit;
> +      do
> +	*op++ = ip[lit];
> +      while (++lit);
> +    }
> +
> +  return op - (u8 *) out_data;
> +}
> 

Since this is a completely new file (as far as kernel tree is concerned)
could you convert it to proper coding style (braces placement, identation)?

-- 
Dmitry
