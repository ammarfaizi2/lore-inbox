Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272340AbTGYSRD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 14:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272341AbTGYSRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 14:17:03 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:31605
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S272340AbTGYSRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 14:17:01 -0400
Message-ID: <3F217A39.2020803@rogers.com>
Date: Fri, 25 Jul 2003 14:43:05 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: Torrey Hoffman <thoffman@arnor.net>, Sam Bromley <sbromley@cogeco.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
References: <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net> <20030725133438.GZ1512@phunnypharm.org> <20030725142907.GI23196@ruvolo.net> <20030725142926.GD1512@phunnypharm.org> <20030725154009.GF1512@phunnypharm.org> <20030725160706.GK23196@ruvolo.net> <20030725161803.GJ1512@phunnypharm.org> <1059155483.2525.16.camel@torrey.et.myrio.com> <20030725181303.GO23196@ruvolo.net> <20030725181252.GA607@phunnypharm.org>
In-Reply-To: <20030725181252.GA607@phunnypharm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.157.78.60] using ID <dw2price@rogers.com> at Fri, 25 Jul 2003 14:32:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do we put this on virgin ieee1394 or on top of the last patch?

Ben Collins wrote:
> Give this a try. It converts the abort_timedouts to a timer that runs
> every 50ms while packets are pending. I'd bet this will increase
> performance a good bit for 1394.
> 
> Expect some offsets for this patch, but it should apply without rejects.

