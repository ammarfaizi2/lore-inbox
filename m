Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWHQWIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWHQWIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 18:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWHQWIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 18:08:42 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:34101 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030216AbWHQWIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 18:08:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=edAIlIKX0b2Ft95vmywZaTjZX+ElEPGYalkCvjaXfkyReERfKkITFcfjQdafcmU58AaCxYytRId+5Lld88N7/UEltSH0h/hZy9tCV8NCTE1sqA6HqaGJ/v408ujcTjfS5kZTlPCiRobQCMBZJnONkKTqVQVas8YP1tLkIjttpFM=
Message-ID: <29495f1d0608171508k2f465419ue5b87ee2847ae3cd@mail.gmail.com>
Date: Thu, 17 Aug 2006 15:08:41 -0700
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Jim Cromie" <jim.cromie@gmail.com>
Subject: Re: 2.6.18-rc4-mm1 Run-time of Locking API testsuite
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <44E4CC60.3080109@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44E4CC60.3080109@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/06, Jim Cromie <jim.cromie@gmail.com> wrote:
>
> Note the non-trivial execution time difference:
>
> soekris:~/pinlab# egrep -e 'Locking|Good' dmesg-2.6.18-rc4-*
> dmesg-2.6.18-rc4-mm1-sk:[   16.044699] | Locking API testsuite:
> dmesg-2.6.18-rc4-mm1-sk:[   96.083576] Good, all 218 testcases passed! |
> dmesg-2.6.18-rc4-sk:[   18.563808] | Locking API testsuite:
> dmesg-2.6.18-rc4-sk:[   19.693692] Good, all 218 testcases passed! |

This is more than just a dmesg difference, I assume? As in, you can
actually tell the difference in time it takes?

Thanks,
Nish
