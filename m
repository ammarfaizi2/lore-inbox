Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264035AbRFYLcS>; Mon, 25 Jun 2001 07:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264062AbRFYLcI>; Mon, 25 Jun 2001 07:32:08 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:60166 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id <S264035AbRFYLb4>; Mon, 25 Jun 2001 07:31:56 -0400
Message-ID: <00c901c0fd6a$5f973680$d55355c2@microsoft>
From: "Alexander V. Bilichenko" <dmor@7ka.mipt.ru>
To: "Matthias Andree" <matthias.andree@stud.uni-dortmund.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <001301c0fcff$47c05160$d55355c2@microsoft> <20010625111657.C13348@emma1.emma.line.org>
Subject: Re: GCC3.0 Produce REALLY slower code!
Date: Mon, 25 Jun 2001 15:31:27 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2488.0001
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2488.0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although I just wanna say that there is no reason trying compile kernel with
new shiny GCC 3.0 ;-). The result will be in kernel slowdown.

Maybe, we can try to use Intel C compiler for some important ;-) (beta
version work with linux).

Best regards,
Alexander                  mailto:www@2ka.mipt.ru
------------------------------------------------------
Let start the war, said Meggy
------------------------------------------------------
----- Original Message -----
From: "Matthias Andree" <matthias.andree@stud.uni-dortmund.de>
To: "Alexander V. Bilichenko" <dmor@7ka.mipt.ru>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, June 25, 2001 1:16 PM
Subject: Re: GCC3.0 Produce REALLY slower code!


> On Mon, 25 Jun 2001, Alexander V. Bilichenko wrote:
>
> > Hello All!
> > Some tests that I have recently check out.
> > kernel compiled with 3.0 (2.4.5) function call: 1000000 iteration. 3%
slower
> > than 2.95.
> > test example - hash table add/remove - 4% slower (compiled both
> > with -O2 -march=i686).
> > Why have this version been released?
>
> Because it comes with various other improvements, among them better
> error detection, better C++ support, integrated GCJ (but regretfully
> still without Ada 95), to name a few reasons.
>
> 3% to 4% loss in a first release of a new major release is not a big
> deal, although I found similar results on leafnode's texpire.
> However, 3% do not warrant me spending my time complaining. Maybe some
> optimization is missing, maybe other operations than the ones you
> checked are faster. So there.
>
> You might run an entire benchmark suite and report back, tough. :-)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

