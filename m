Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314596AbSEFRML>; Mon, 6 May 2002 13:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314597AbSEFRMK>; Mon, 6 May 2002 13:12:10 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:12478 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S314596AbSEFRMK>; Mon, 6 May 2002 13:12:10 -0400
Message-Id: <5.1.0.14.0.20020506095714.01ad3ab8@mage.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 06 May 2002 10:12:02 -0700
To: linux-kernel@vger.kernel.org
From: Vijay Kumar <jkumar@qualcomm.com>
Subject: Limiting disk data transfer rate, Any help greatly appreciated
Cc: Vijay Kumar <jkumar@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

In my project we have a RAID connected to more than one machine via fibre 
channel switch. The RAID bandwidth is shared among  machines, some of them 
reading data at a high rate (for video streaming) and at lease one machine 
writing data into it. Since the raid bandwidth is limited, we would like to 
specify how the bandwidth is distributed among machines. This can not be 
done either in the FC switch or in the RAID, so my only option right now is 
have to specify the available bandwidth and limit the rate at which linux 
reads data from the RAID.

I am wondering if there is a way in the linux to specify the maximum 
bandwidth that could used with a disk. In other words I am looking for a 
driver level implementation that does the throttling when the maximum 
bandwidth limit is hit while reading/writing data to/from a disk.

Any help or pointers to possible solutions is greatly appreciated. I am not 
on the list, so please CC me with your responses and suggestions.


Thank you all

- Vijay

