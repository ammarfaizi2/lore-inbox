Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289589AbSA2Mar>; Tue, 29 Jan 2002 07:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289564AbSA2M3a>; Tue, 29 Jan 2002 07:29:30 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:10374 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S289647AbSA2M2n>; Tue, 29 Jan 2002 07:28:43 -0500
Message-ID: <3C56943E.60405@antefacto.com>
Date: Tue, 29 Jan 2002 12:23:26 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Francesco Munda <syylk@libero.it>
CC: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> <200201290137.g0T1bwB24120@karis.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francesco Munda wrote:

> On Mon, 28 Jan 2002 09:10:56 -0500
> Rob Landley <landley@trommello.org> wrote:
> 
> 
>>Patch Penguin Proposal.
>>
>>[...]
>>
> 
> You mean some sort of proxy/two-tier development? A "commit/rollback"
> transaction model on the kernel itself?


Dave Jones described the current model very succinctly in:

http://marc.theaimsgroup.com/?l=linux-kernel&m=100966905916285&w=2

He also mentioned a big problem. People not honouring/realising
there position in the tree, (trying to get in the ChangeLog?).
True, the only way to scale it is add another level at the current
bottleneck, but this must be more than 1 person or it won't help,
as it'll just move the bottelneck back a little.

Personally I think automated tools (like bitkeeper) would help
more than another level in the hierarchy.

Currently the way I see it [should be] currently is:

random hackers
| | | | | | |
| maintainers
| | | |
combiners
| |
Linus

I.E. Linus just gets input from the combiners which
test logic from the maintainers in combination. Also
random hackers should input to the combiners and not Linus
if there isn't an appropriate maintainer for their code.

Padraig.

