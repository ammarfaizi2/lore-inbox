Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287596AbSA0NeL>; Sun, 27 Jan 2002 08:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287141AbSA0NeB>; Sun, 27 Jan 2002 08:34:01 -0500
Received: from pc3-redb4-0-cust131.bre.cable.ntl.com ([213.106.223.131]:61177
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S287596AbSA0Ndv>; Sun, 27 Jan 2002 08:33:51 -0500
Date: Sun, 27 Jan 2002 13:33:48 +0000
From: Mark Zealey <mark@zealos.org>
To: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: fonts corruption with 3dfx drm module
Message-ID: <20020127133348.GB23825@itsolve.co.uk>
In-Reply-To: <20020127122501.GA23825@itsolve.co.uk> <000301c1a732$a989fa80$132f23d9@stratus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000301c1a732$a989fa80$132f23d9@stratus>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux sunbeam 2.4.17-wli2 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2002 at 01:00:57PM -0000, Daniel J Blueman wrote:

> Do you have a graphical console or text? I believe there are fixes in
> 2.4.18-preX to decrease the 3dfx banshee/v3 pixel clock or something to
> alleviate this issue. That'll be in the 3dfx framebuffer driver.
> 
> Or, of course, it could be something entirely different....

Text at something like 32x80 and graphics in X at 640x480. This seems to be a
character map corruption problem, like an > will only have the / bit showing on
it, or an ! will be half-sized etc. Also happens with other chars, but a flip
back into X and then console again usially fixes it

-- 

Mark Zealey
mark@zealos.org
mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a16! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ N- !o? !w--- O? !M? !V? !PS !PE--@ PGP+? r++ !t---?@ !X---?
!R- b+ !tv b+ DI+ D+? G+++ e>+++++ !h++* r!-- y--

(www.geekcode.com)
