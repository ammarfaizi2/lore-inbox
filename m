Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271734AbTGXUzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 16:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271737AbTGXUzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 16:55:22 -0400
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:17312
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id S271734AbTGXUzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 16:55:15 -0400
Message-ID: <3F204B3B.3040802@tupshin.com>
Date: Thu, 24 Jul 2003 14:10:19 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030710
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Daniel Egger <degger@fhm.edu>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org,
       reiserfs mailing list <reiserfs-list@namesys.com>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
References: <3F1EF7DB.2010805@namesys.com>	<1059062380.29238.260.camel@sonja> <16160.4704.102110.352311@laputa.namesys.com>
In-Reply-To: <16160.4704.102110.352311@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Daniel Egger writes:
> > 
> > How failsafe is it to switch off the power several times? When the
> > filesystem really works atomically I should have either the old or the
> > new version but no mixture. Does it still need to fsck or is the
> > transaction replay done at mount time? In case one still needs fsck,
> > what's the probability of needing user interaction? How long does it
> > need to get a filesystem back into a consistent state after a powerloss
> > (approx. per MB/GB)?
>
>I should warn everybody that reiser4 is _highly_ _experimental_ at this
>moment. Don't use it for production.
>
I'd like to ask this question differently: How failsafe is reiserfs4 
*theoretically*. Assuming no bugs in implementation, what is the true 
import of its atomic nature? Strengths and potential weaknesses?

-Thanks
-Tupshin

