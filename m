Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287754AbSAAF0J>; Tue, 1 Jan 2002 00:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287750AbSAAFZ7>; Tue, 1 Jan 2002 00:25:59 -0500
Received: from femail22.sdc1.sfba.home.com ([24.0.95.147]:61139 "EHLO
	femail22.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287751AbSAAFZo>; Tue, 1 Jan 2002 00:25:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Larry McVoy <lm@bitmover.com>
Subject: Re: The direction linux is taking
Date: Mon, 31 Dec 2001 16:24:01 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201010132.g011W5TS001771@sleipnir.valparaiso.cl>
In-Reply-To: <200201010132.g011W5TS001771@sleipnir.valparaiso.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020101052543.TJWJ14077.femail22.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 December 2001 08:32 pm, Horst von Brand wrote:

> Hummm... I guess this is because yoiu see new (development, pre, ...)
> kernels each few days. Alan said he gets mosly line shifts (==
> non-overlapping patches, or "people should be talking to each other").
> Maybe due to the rapid version turnover? Maybe most of the merging is being
> done by the posters themselves during development, as Ye Kernel Gods refuse
> to do it for them?

Ye kernel gods can spend an afternoon reviewing 15 patches that apply cleanly 
to see if their changes are a good idea, or they can spend that afternoon 
cleaning up and merging one.

Cleaning up and marging is something the patch's author can do, or thousands 
of other random developers on the list.  Exerting editorial judgement on what 
is and isn't a good idea is NOT something everybody else can do.

Which is a better use of the maintainer's time?

> I'm surprised that commercial shops see much merging. I'd assume they have
> direct access to the up-to-the-minute source, so _less_ merging should be
> necesary. Or they are (over)confident in their tools, and just work on
> stale sources?

Commercial shops believe that developers are interchangeable, and that 
developers should know what it is they're going to do before they do it.  So 
if you have three pending changes in this area of the code, you assign them 
to three developers in paralell as a matter of course.  (Then there's code 
reviews with people who disagree with your choice of variable and function 
names EVERY TIME...  But we won't go there.)

A medium-small change in a commercial shop can easily take two weeks, and you 
have to check the code out to do it.  (This locks the code you've changed so 
nobody else can change it until you check the changed files back in or 
somebody with administrator access breaks the lock.)  So either:

You check out the files you're going to change and keep them checked out for 
a week or two while you design, implement, test, code review, make the 
changes the code reviewer wants (it's like getting your car inspected, they 
always find something you need even if it's just busy-work), test again, yell 
at the code reviewer for making a stupid suggestion that shows a profound 
lack of understanding of the code, have a meeting to resolve it, lose, have 
to write a workaround in a completely unrelated section of the code, wait for 
the guy in the testing lab to get back from vacation...

Ahem.  Either you keep the files checked out all that time, or you check them 
out at the last minute (tracking down whoever has the last two files you need 
checked out and getting them to check them back in), merge your changes with 
what's there (often a good day's worth of work right there), and check it 
back in.  Except when you have to get your merge code reviewed, and then a 
manager to sign off on the fact it's BEEN code reviewed, and then it goes to 
test again...

Yes, merging is a big deal in Fortune 500 shops.  Read the mythical 
man-month... :)

> > Some sociology guy with a CS background should do a study on this and
> > explore the differences.  Is fast change better?  Is slow change better?
>
> I think the difference lies elsewhere.

Between the mythical man-month, the cathedral and the bazaar, and the 
innovator's dilemma, I think the study's already been done.  But since no 
graduate student's taken credit for a thesis or dissertation on it yet, I'm 
sure there's still an opportunity to take credit in the ivory towers of 
academia...

Rob
