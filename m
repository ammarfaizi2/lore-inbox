Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274865AbRIUW6T>; Fri, 21 Sep 2001 18:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274867AbRIUW6G>; Fri, 21 Sep 2001 18:58:06 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:35599 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S274865AbRIUW5q>;
	Fri, 21 Sep 2001 18:57:46 -0400
Date: Fri, 21 Sep 2001 19:57:52 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
Cc: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: major VM  with 2.4.10pre12 and 2.4.10pre13 and highmem, we  w
 ill help test
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D544@xfc01.fc.hp.com>
Message-ID: <Pine.LNX.4.33L.0109211951100.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, DICKENS,CARY (HP-Loveland,ex2) wrote:

> I'm working with Erik and need to know which of the 3 patches ( or all )
> that you want data for.  We are setting up the plain test right now.
>
> aging

This one has just page aging changes versus 2.4.9-ac12
and should be the most interesting one.

> aging+launder
> aging2launder

This one adds a changed page_launder() function, I'm not
sure how much of an impact that makes. The first patch
includes the page aging, the second one is incremental
to the page aging patch above ;)

The one I'd like to see tested most is the page aging
one, but if you have the time it'd be interesting to see
the results from the changed page_launder() too.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

