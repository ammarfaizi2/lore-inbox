Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289363AbSAPWNT>; Wed, 16 Jan 2002 17:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289568AbSAPWNJ>; Wed, 16 Jan 2002 17:13:09 -0500
Received: from pc4-redb4-0-cust129.bre.cable.ntl.com ([213.107.130.129]:54766
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S289156AbSAPWMu>; Wed, 16 Jan 2002 17:12:50 -0500
Date: Wed, 16 Jan 2002 22:12:47 +0000
From: Mark Zealey <mark@zealos.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: floating point exception
Message-ID: <20020116221247.GA3769@itsolve.co.uk>
In-Reply-To: <3C45F7B6.1BCB4519@didntduck.org> <Pine.LNX.3.95.1020116170247.15437A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020116170247.15437A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux sunbeam 2.4.17-wli2 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 05:05:55PM -0500, Richard B. Johnson wrote:

>     for(;;)
>     {
>         srand(seed); 
>         z = x;
>         for(i = 0; i < MAX_FLOAT; i++)
>             *z++ = cos((double) rand());
>         srand(seed);
>         z = y;
>         for(i = 0; i < MAX_FLOAT; i++)
>             *z++ = cos((double) rand());
>         if(memcmp(x, y, MAX_FLOAT * sizeof(double)))
>             break;
>         seed = rand();

Um, maybe I'm not reading this properly.. why are you randing, doing 1 set and
then using different random values for the other set ?

-- 

Mark Zealey
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
