Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291152AbSBGPEh>; Thu, 7 Feb 2002 10:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291155AbSBGPEW>; Thu, 7 Feb 2002 10:04:22 -0500
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:29152 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S291152AbSBGPEG>; Thu, 7 Feb 2002 10:04:06 -0500
Importance: Normal
Subject: Re: The IBM order relaxation patch
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>, <zaitcev@redhat.com>,
        <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFDEA688CD.7104528D-ONC1256B59.00522C09@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Thu, 7 Feb 2002 16:05:28 +0100
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 07/02/2002 16:05:32
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik van Riel wrote:

>On Thu, 7 Feb 2002, Daniel Phillips wrote:
>
>> Yes, that's one of leading reasons for wanting rmap.  (Number one and
>> two reasons are: allow forcible unmapping of multiply referenced pages
>> for swapout; get more reliable hardware ref bit readings.)
>
>It's still on my TODO list.  Patches are very much welcome
>though ;)

On s390 we have per physical page hardware referenced / changed bits.
In the rmap framework, it should also be possible to make more efficient
use of these ...


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

