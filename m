Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbRENB3O>; Sun, 13 May 2001 21:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbRENB3E>; Sun, 13 May 2001 21:29:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19594 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262043AbRENB2t>; Sun, 13 May 2001 21:28:49 -0400
Importance: Normal
Subject: Minor numbers
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF2C42607E.899F4413-ON87256A4C.00068D2E@LocalDomain>
From: "Alex Q Chen" <aqchen@us.ibm.com>
Date: Sun, 13 May 2001 18:28:46 -0700
X-MIMETrack: Serialize by Router on D03NM080/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 05/13/2001 07:28:48 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To the best of my knowledge, dev_t number is still 16 bits with 8 most
significant bits being the major number and the other 8 bits being the
minor number; which of course means that minor numbers can only go up to
255.  Has this limitation been some how addressed with 2.4?  256 devices
per module, sometimes is not enough, especially if you are in the SAN
environment; or when the 256 minors numbers are broken down to several
ranges of numbers to address different types of special files.  I don't see
how this problem can be solved with dev_fs either.  Anyone out there with a
work-around or is proposing a solution?  I believe that minor and major
numbers for SUN and AIX are both 16 bits each (32 bits dev_t).

Thanks in advance for your input.

Thanks!

Sincerely,
Alex Chen

IBM SSD Device Driver Development
Office: 9000 S. Rita Rd 9032/2262
Email: aqchen@us.ibm.com
Phone: (external) 520-799-5212 (Tie Line) (321)-5212

