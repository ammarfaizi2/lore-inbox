Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbRE2TNG>; Tue, 29 May 2001 15:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261535AbRE2TM4>; Tue, 29 May 2001 15:12:56 -0400
Received: from cliff.mcs.anl.gov ([140.221.9.17]:3457 "EHLO mcs.anl.gov")
	by vger.kernel.org with ESMTP id <S261509AbRE2TMv>;
	Tue, 29 May 2001 15:12:51 -0400
To: miquels@cistron-office.nl (Miquel van Smoorenburg)
Cc: linux-kernel@vger.kernel.org
Subject: Re: serial console problems under 2.4.4/5
In-Reply-To: <yrxofscdnpj.fsf@terra.mcs.anl.gov>
	<9f0qoj$ttr$1@ncc1701.cistron.net>
From: "Narayan Desai" <desai@mcs.anl.gov>
Date: 29 May 2001 14:12:43 -0500
In-Reply-To: <9f0qoj$ttr$1@ncc1701.cistron.net>
Message-ID: <yrxsnhot1ec.fsf@terra.mcs.anl.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Mike" == Miquel van Smoorenburg <miquels@cistron-office.nl> writes:

Mike> In article <yrxofscdnpj.fsf@terra.mcs.anl.gov>,
Mike> Narayan Desai <desai@mcs.anl.gov> wrote:
>> Hi. I have started having serial console problems in the last bunch
>> of kernel releases. I have tried various 2.4.4 and 2.4.5 ac kernels
>> (up to and including 2.4.5-ac4) and the problem has persisted. The
>> problem is basically that serial console doesn't recieve.

Mike> The serial driver now pays attention to the CREAD bit. Sysvinit
Mike> clears it, so that's where it goes wrong.

Mike> I don't think this change should have gone into a 'stable'
Mike> kernel version. 2.5.0 would have been fine, not 2.4.4

How would I go about resetting this so that serial console worked
again? thanks...
 -nld
