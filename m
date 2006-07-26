Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751791AbWGZWHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWGZWHa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 18:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWGZWH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 18:07:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:25983 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751791AbWGZWH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 18:07:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NaJkTIEORU1rn5qgFtNskdY1d+RxzbxsyzHZnFaII1vHVfaJCNLT7M0tHKaZI6fa8i/1Mk7ksPfHcVP03MjXxY4s8D+ES215+2awjS6fYSa38yyctgkwKf+uP5Ey3Bo2Oadc0uufmnoy0sFEDXxrlCfT/HbUbjLdJLflvM+ezQ8=
Message-ID: <b1bc6a000607261507g663ad95cwcc4a2ae4622e0fa2@mail.gmail.com>
Date: Wed, 26 Jul 2006 15:07:28 -0700
From: "adam radford" <aradford@gmail.com>
To: "dean gaudet" <dean@arctic.org>
Subject: Re: 3ware disk latency?
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Jan Kasprzak" <kas@fi.muni.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607261440470.4568@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710141315.GA5753@fi.muni.cz>
	 <Pine.LNX.4.64.0607260942110.22242@twinlark.arctic.org>
	 <1153946249.13509.29.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607261440470.4568@twinlark.arctic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/06, dean gaudet <dean@arctic.org> wrote:
>
> unfortunately when i did the experiment i neglected to perform
> simultaneous tests on more than one 3ware unit on the same controller.  i
> got great results from a raid1 or from a raid10 (even a raid5)... but
> never i only tested one unit at a time.
>

Did you try setting /sys/class/scsi_host/hostX/cmd_per_lun to 256 / num_units ?

-Adam
