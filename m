Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313332AbSDQKIg>; Wed, 17 Apr 2002 06:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313434AbSDQKIg>; Wed, 17 Apr 2002 06:08:36 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:39055 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S313332AbSDQKIf>; Wed, 17 Apr 2002 06:08:35 -0400
Date: Wed, 17 Apr 2002 12:07:47 +0200
From: Felix Braun <Felix.Braun@mail.McGill.ca>
To: linux-kernel@vger.kernel.org
Subject: Serial Driver problems with 2.4.19-pre7
Message-Id: <20020417120747.4afd893a.Felix.Braun@mail.McGill.ca>
Organization: Vectrix -- Legal Department
X-Mailer: Sylpheed version 0.7.4claws80 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I just tested 2.4.19-pre7 and the serial driver (which is built as a
module inserted on demand by devfs) assigns port numbers off by one as
compared to pre6. That is /dev/tts/0 is now /dev/tts/1 and /dev/tts/1 is
now /dev/tts2. This change breaks many configuration scripts, so it should
possibly be fixed until 2.4.19-final. If I can help in that process please
tell me which further tests I should conduct.

Bye
Felix
