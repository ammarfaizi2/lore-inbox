Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWH3Bpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWH3Bpq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 21:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWH3Bpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 21:45:46 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:52023 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750804AbWH3Bpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 21:45:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OMmpmikRfyTSSoLb5BE9C2NVM3c0WnQ/U6qEoYG5eH/vrX7ADl0QOrgsS+L/qs2LsKQoHWs2RiwqD15FXvskc/usp2FTGif2hJzipwN2ChizRpdxPh3Qw8jFjALcIJh7g9V2PDw95YtW9X8EikcXhi01+DdzlTOPNeNlQdMYSW0=
Message-ID: <b6a2187b0608291845l17532458hf0aaf22e247b5b37@mail.gmail.com>
Date: Wed, 30 Aug 2006 09:45:43 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Nigel Cunningham" <ncunningham@linuxmail.org>
Subject: Re: megaraid_sas suspend ok, resume oops
Cc: "Jens Axboe" <axboe@kernel.dk>, Sreenivas.Bagalkote@lsil.com,
       Sumant.Patro@lsil.com, jeff@garzik.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1156895131.3232.25.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com>
	 <20060829081518.GD12257@kernel.dk>
	 <b6a2187b0608290522vea22930y54ac39bfce3127f2@mail.gmail.com>
	 <1156895131.3232.25.camel@nigel.suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/06, Nigel Cunningham <ncunningham@linuxmail.org> wrote:
>
> Neither swsusp (as far as I know) or suspend2 support CONFIG_HIGHMEM64G
> at the moment, I'm afraid.
>
> It's not impossible, we just haven't seen it as a priority worth putting
> time into. Do you really have more than 4GB of RAM and want to suspend
> to disk?

It'll be really "nice" to have. Currently all the production systems
simply shutdown all databases and applications and put systems to a
halt. But, I'm thinking of implementing suspend_to_disk instead of
shutdown the database and applications, so when power resumes, the
system can carry on where it was left off. Nice, very nice feature to
have.
It's "nice" because nobody has tried, and if this works, I don't see
why not use it for all machines in a data center.

The DELL 2950 has 16GB of RAM, and will be running oracle database.
