Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262476AbTCMRJx>; Thu, 13 Mar 2003 12:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262478AbTCMRJx>; Thu, 13 Mar 2003 12:09:53 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32718
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262476AbTCMRJw>; Thu, 13 Mar 2003 12:09:52 -0500
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: James Stevenson <james@stev.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20030313171426.GK836@suse.de>
References: <20030227221017.4291c1f6.skraw@ithnet.com>
	 <014b01c2e978$701050e0$0cfea8c0@ezdsp.com> <20030313163707.GH836@suse.de>
	 <016c01c2e980$b2d4ee60$0cfea8c0@ezdsp.com> <20030313164617.GI836@suse.de>
	 <017e01c2e983$865e9bd0$0cfea8c0@ezdsp.com>  <20030313171426.GK836@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047580119.25949.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 13 Mar 2003 18:28:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 17:14, Jens Axboe wrote:
> Ok, please reproduce in 2.4.21-pre5, its end_request handling is a lot
> different. If you just want a one-liner, I'd suggest trying something
> ala this on 2.4.20 and see if it makes any difference:

The do_reset code is also racey in some cases on 2.4.21 < pre5-ac2

