Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316997AbSHZM7y>; Mon, 26 Aug 2002 08:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSHZM7y>; Mon, 26 Aug 2002 08:59:54 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:43432 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316997AbSHZM7x>; Mon, 26 Aug 2002 08:59:53 -0400
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
To: jamal <hadi@cyberus.ca>, davem@redhat.com
Cc: netdev@oss.sgi.com, Robert Olsson <Robert.Olsson@data.slu.se>,
       "Bill Hartner" <bhartner@us.ibm.com>, <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFFFA46B92.252E5659-ON87256C21.000BB73B@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Mon, 26 Aug 2002 08:04:05 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/26/2002 07:04:04 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I think the skbinit patch and recycling skbs are mutually exclusive.

>I would say they are more orthogonal than mutually exclusive.
>Although ou still need to prove that relocating the code actually helps in
>real life. On paper it looks good.
Troy Wilson (who works with me) posted SPECweb99 results using my
skbinit patch to lkml on Friday:
 http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.2/1470.html
I know you don't subscribe to lkml. Have you seen these results?
On Numa machine it showed around 3% improvement using SPECweb99.


Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088





