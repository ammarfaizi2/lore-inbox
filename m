Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbUKCUa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUKCUa6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbUKCUa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:30:58 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:25729 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261785AbUKCUax
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:30:53 -0500
Message-ID: <418940AA.7000809@tmr.com>
Date: Wed, 03 Nov 2004 15:33:46 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sai Prathap <saiprathap@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Installing software on a knoppix CD
References: <69cfd1b80411031106663a1cc8@mail.gmail.com>
In-Reply-To: <69cfd1b80411031106663a1cc8@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sai Prathap wrote:
> Hi,
> 
> I have a question regarding knoppix. If we boot from a knoppix CD, Is
> it possible to get any software installed on it ? Because, whenever I
> try to install something  it says its not writable. Please advice.

*If* there is room on the CD, you can add things to the image and burn a 
new CD. The "right" method is to mount the CD and copy everything into a 
directory, add the new material, run mkisofs with the right boot options 
to make a bootable image, and burn the image.

If you are heavily into burning CDs, you *MIGHT* be able to extract the 
ISO image, reburn it with the cdrecord -multi option, and then add your 
own stuff in a second session. I haven't tried this, and if you aren't 
familiar with burning multisession CDs it's eather a learning experience 
or a good thing to avoid.

Check first to see if there's any room on the CD for more stuff!

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
