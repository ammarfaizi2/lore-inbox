Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263461AbRFMLjp>; Wed, 13 Jun 2001 07:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263469AbRFMLje>; Wed, 13 Jun 2001 07:39:34 -0400
Received: from u-115-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.115]:44023
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S263461AbRFMLjU>; Wed, 13 Jun 2001 07:39:20 -0400
Date: Wed, 13 Jun 2001 12:39:01 +0200
From: Ralf Baechle <ralf@conectiva.com.br>
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Cc: "'Rik van Riel'" <riel@conectiva.com.br>,
        Rob Landley <landley@webofficenow.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Matt Nelson <mnelson@dynatec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Any limitations on bigmem usage?
Message-ID: <20010613123901.A31221@bacchus.dhis.org>
In-Reply-To: <3AB544CBBBE7BF428DA7DBEA1B85C79C9B6AE1@nocmail.ma.tmpw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AB544CBBBE7BF428DA7DBEA1B85C79C9B6AE1@nocmail.ma.tmpw.net>; from bruce.holzrichter@monster.com on Tue, Jun 12, 2001 at 02:34:40PM -0400
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2001 at 02:34:40PM -0400, Holzrichter, Bruce wrote:

> > Brilliant.  You need what, a 6x larger cache just to break even with
> > the amount of time you're running in-cache? 
> 
> This may be the wrong platform for this question, but after reading Rob
> Landley's note on performance on Itanium and architecture concerns, I am
> interested in Kernel hackers who have had to write code for Itanium's
> comments on the same, if you are not bound by NDA's.  Correct me if I am
> wrong, but I thought I saw the announcement that Itanium is shipping.  Have
> you tested Itanium performance?  We have an preproduction unit with quad
> Itanium's.  I have not had time to benchmark against other units, I am
> interested in performance items.  Feel free to drop me a line off list if
> you can.

A number of Specbench numbers of Itanium systems is now available.  Itanium
performs relativly bad for the integer numbers compared to the entire
competition but is a true fp killer.  As a developer I hate that compiling
code for Itanium due to the extra complexity of optimization and code
generation is way slower than for others CPUs.  So all in all Itanium is
a two edged sword.

  Ralf
