Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129539AbQK3OpS>; Thu, 30 Nov 2000 09:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129707AbQK3OpH>; Thu, 30 Nov 2000 09:45:07 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:48370 "HELO
        brinquedo.distro.conectiva") by vger.kernel.org with SMTP
        id <S129539AbQK3OpD>; Thu, 30 Nov 2000 09:45:03 -0500
Date: Thu, 30 Nov 2000 12:14:28 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: oyvind@datavakten.no (Øyvind Jægtnes)@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: get_user_ret
Message-ID: <20001130121428.D5192@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        oyvind@datavakten.no (Øyvind Jægtnes),
        linux-kernel@vger.kernel.org
In-Reply-To: <87sno9s8gk.fsf@isengard.alfanett.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <87sno9s8gk.fsf@isengard.alfanett.no>; from oyvind@datavakten.no on Thu, Nov 30, 2000 at 05:58:19PM +0100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 30, 2000 at 05:58:19PM +0100, Øyvind Jægtnes escreveu:
> 
> This get_user_ret thing seems to have changed again... what is the
> correct syntax now?

if (get_user(blah, bleh))
	return -EFAULT;

*_user*_ret is gone for good.

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
