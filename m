Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLLE2e>; Mon, 11 Dec 2000 23:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129352AbQLLE2Y>; Mon, 11 Dec 2000 23:28:24 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:24843 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129226AbQLLE2G>; Mon, 11 Dec 2000 23:28:06 -0500
Date: Mon, 11 Dec 2000 21:57:07 -0600
To: Georg Nikodym <georgn@somanetworks.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
        greg@wind.enjellic.com, sct@redhat.com,
        Linus Torvalds <torvalds@transmeta.com>,
        "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: linux-2.4.0-test11 and sysklogd-1.3-31
Message-ID: <20001211215707.D3199@cadcamlab.org>
In-Reply-To: <14901.31690.961664.201896@somanetworks.com> <3586.976584600@kao2.melbourne.sgi.com> <14901.34060.536976.829050@somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14901.34060.536976.829050@somanetworks.com>; from georgn@somanetworks.com on Mon, Dec 11, 2000 at 08:53:16PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Georg Nikodym]
> +		    case 'x':
> +			fprintf(stderr,
> +				"klogd: %c option is obsolete.  Ignoring\n", ch);

Clearer (IMHO):          "klogd: warning: ignoring obsolete option '-%c'\n", ch);

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
