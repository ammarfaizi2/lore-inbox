Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVFUWfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVFUWfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVFUWeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:34:37 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:27298 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S262463AbVFUVPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:15:44 -0400
Message-ID: <42B8735C.4090606@brturbo.com.br>
Date: Tue, 21 Jun 2005 17:06:52 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: 2.6.12-mm1
References: <20050619233029.45dd66b8.akpm@osdl.org>	<20050620202947.040be273.khali@linux-fr.org>	<20050620134146.0e5de567.akpm@osdl.org>	<20050620231147.7232d889.khali@linux-fr.org>	<20050620142323.2ed2180b.akpm@osdl.org> <20050620234202.3c605b89.khali@linux-fr.org>
In-Reply-To: <20050620234202.3c605b89.khali@linux-fr.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean,

Jean Delvare wrote:

>Hi Andrew,
>
>  
>
>>One could go on at length as to why this mistake is so easy to make
>>when you're using CVS, but what it boils down to is that these
>>projects are using the wrong paradigm.  They're maintaining files,
>>whereas they should be maintaining *changes* to files.
>>    
>>
>
>My point exactly. You seem to excuse them for providing broken patches
>because they use the wrong tools to do the job in the first place, I
>don't (and I'm not even you). If CVS doesn't work, let's not use it.
>There are other tools out there which will do the job just fine (one of
>them being quilt [1], which makes my own job so much easier since I'm
>using it, thanks to its various authors and contributors).
>
>[1] http://savannah.nongnu.org/projects/quilt/
>
    For a period of two or three months, V4L maintainer (Gerd Knorr)
quited as a maintainer, but V4L activities has not gone... lots of new
improvements was done since them, but not applied due to lack of a
maintainer.

    This patchset was a series of patches to synchronize both structures
(kernel AND v4l devel).

     We are aware of the regression caused by these patches (promptly
corrected), and will take efforts to ensure this doesn't happen again.

    Mauro.
