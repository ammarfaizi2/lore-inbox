Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbUKVWSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbUKVWSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbUKVWPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:15:39 -0500
Received: from main.uucpssh.org ([212.27.33.224]:63683 "EHLO main.uucpssh.org")
	by vger.kernel.org with ESMTP id S262416AbUKVWPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:15:12 -0500
To: linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org
Subject: dvb-ttpci not smp safe [was: [linux-dvb-maintainer] [patch]
 2.6.10-rc2-mm3: DVB: philips_tdm1316l_config multiple definition]
References: <20041121223929.40e038b2.akpm@osdl.org>
	<20041122155123.GE19419@stusta.de>
	<20041122160955.GA18255@convergence.de> <41A21B71.8060001@linuxtv.org>
From: syrius.ml@no-log.org
Message-ID: <87hdnhlfoi.87fz31lfoi@87ekillfoi.message.id>
Date: Mon, 22 Nov 2004 23:08:43 +0100
In-Reply-To: <41A21B71.8060001@linuxtv.org> (Michael Hunold's message of
 "Mon, 22 Nov 2004 18:01:37 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hunold <hunold@linuxtv.org> writes:

>> BTW, like I said in some previous mail I think this "Big DVB update"
>> isn't ready for prime time yet. It breaks support for some
>> DVB cards (partially fixed in linuxtv.org CVS), so I think
>> this should not go into the mainline kernel now. IMHO it's better
>> to wait until 2.6.10 is out.
>> Michael: Do you think differently?
> Nope. But in my mail to Andrew and Linus I said that it shouldn't go
> into 2.6.10 yet, but instead get some testing in -mm.
> So Andrew, please hold this in -mm until we have fixed the remaining
> problems. I'll feed with you with update patches.

Will those updates fix the smp issues with dvb-ttpci ?
As I wrote before, i'm not in a position where i can fix it myself.
I read a lot of people had to move their dvb card to a single-cpu (non
ht one) because of the crashes.
at moment i can't buy another box neither can I offer the
dvb-mainteners a smp box.

Thanks for your work.

-- 
