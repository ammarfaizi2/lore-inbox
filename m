Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272361AbRH3RgH>; Thu, 30 Aug 2001 13:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272362AbRH3Rf5>; Thu, 30 Aug 2001 13:35:57 -0400
Received: from smtp102.urscorp.com ([64.17.27.233]:61704 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S272361AbRH3Rfr>; Thu, 30 Aug 2001 13:35:47 -0400
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OF071248D9.F16220EF-ON85256AB8.0059A701@urscorp.com>
Date: Thu, 30 Aug 2001 13:32:34 -0400
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 08/30/2001 01:35:34 PM,
	Serialize complete at 08/30/2001 01:35:34 PM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So I have this number, -200, which is stored in an int. I have this 
other
> number, 200, which is stored in an unsigned char. Everybody in his right
> mind will agree that -200 is smaller than 200, the compiler will do just
> that, yet you disagree???

Now try doing that with an int and an unsigned int, you'll get 200, not 
-200.

Mike


