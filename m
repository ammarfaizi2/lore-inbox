Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263112AbREaQyI>; Thu, 31 May 2001 12:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263109AbREaQx6>; Thu, 31 May 2001 12:53:58 -0400
Received: from zmsvr04.tais.net ([12.106.80.12]:32014 "EHLO zmsvr04.tais.net")
	by vger.kernel.org with ESMTP id <S263106AbREaQxu>;
	Thu, 31 May 2001 12:53:50 -0400
To: linux-kernel@vger.kernel.org
Cc: kErNeL-kRaCkEr@home.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFCA65A58C.155A1FB1-ON88256A5D.005BDA7A@tais.net>
From: Ramil.Santamaria@tais.toshiba.com
Date: Thu, 31 May 2001 09:53:43 -0700
X-MIMETrack: Serialize by Router on zmsvr04/tais_external(Release 5.0.6a |January 17, 2001) at
 05/31/2001 09:53:50 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor issue with bootsect.s.

The single instance of the lds assembly instruction includes the comment of
!  ds:si is source
...
seg fs
lds  si,(bx)        !     ds:si is source
...
Is this comment not in reverse order (i.e should be lds
dest,src)................


Ramil J.Santamaria
Toshiba America Information Systems
ramil.santamaria@tais.toshiba.com

