Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290944AbSBLKTA>; Tue, 12 Feb 2002 05:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290930AbSBLKSu>; Tue, 12 Feb 2002 05:18:50 -0500
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:47342 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S290944AbSBLKSj>; Tue, 12 Feb 2002 05:18:39 -0500
Importance: Normal
Subject: Re: [PATCH] linux-2.417 devfs 64bit portablility issue
To: "David S. Miller" <davem@redhat.com>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org, rgooch@ras.ucalgary.ca
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF4AA25699.AF6F32E2-ONC1256B5E.003DC174@de.ibm.com>
From: "Carsten Otte" <COTTE@de.ibm.com>
Date: Tue, 12 Feb 2002 12:18:38 +0100
X-MIMETrack: Serialize by Router on D12ML033/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 12/02/2002 11:19:56
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@redhat.com> wrote:
>No, I tried to do that once, but the casts become stupid
>and ugly.

I agree, and with explicit casts the compiler still would'nt even print a
warning
when the bitops are incorrectly used.

w/kind regards
Carsten Otte

